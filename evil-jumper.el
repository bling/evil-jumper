;;; evil-jumper.el --- Jump like vimmers do!

;; Copyright (C) 2014 by Bailey Ling
;; Author: Bailey Ling
;; URL: https://github.com/bling/evil-jumper
;; Filename: evil-jumper.el
;; Description: Jump like vimmers do!
;; Created: 2014-07-01
;; Version: 0.0.1
;; Keywords: evil vim jumplist jump list
;; Package-Requires: ((evil "0"))
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Commentary:
;;
;; Install:
;; (require 'evil-jumper)
;;
;; Usage:
;;
;; Requiring will automatically rebind C-o and C-i.

;;; Code:

(require 'evil)

(defgroup evil-jumper nil
  "evil-jumper configuration options."
  :prefix "evil-jumper"
  :group 'evil)

(defcustom evil-jumper-max-length 100
  "The maximum number of jumps to keep track of."
  :type 'integer
  :group 'evil-jumper)

(defcustom evil-jumper-auto-center nil
  "Auto-center the line after jumping."
  :type 'boolean
  :group 'evil-jumper)

(defvar evil-jumper--list nil)
(defvar evil-jumper--idx -1)
(defvar evil-jumper--jumping nil)

(defun evil-jumper--jump-to-index (idx)
  (when (>= idx (length evil-jumper--list))
    (setq idx 0))
  (when (< idx 0)
    (setq idx (- (length evil-jumper--list) 1)))
  (setq evil-jumper--idx idx)
  (let* ((place (nth idx evil-jumper--list))
         (pos (car place))
         (file-name (cadr place)))
    (setq evil-jumper--jumping t)
    (if (equal file-name "*scratch*")
        (switch-to-buffer file-name)
      (find-file file-name))
    (setq evil-jumper--jumping nil)
    (goto-char pos)
    (when evil-jumper-auto-center
      (recenter))))

(defun evil-jumper--push ()
  (while (> (length evil-jumper--list) evil-jumper-max-length)
    (nbutlast evil-jumper--list 1))
  (let ((file-name (buffer-file-name))
        (buffer-name (buffer-name))
        (current-pos (point))
        (first-pos nil)
        (first-file-name nil))
    (when (and (not file-name) (equal buffer-name "*scratch*"))
      (setq file-name buffer-name))
    (when evil-jumper--list
      (setq first-pos (caar evil-jumper--list))
      (setq first-file-name (cadar evil-jumper--list)))
    (unless (and (equal first-pos current-pos)
                 (equal first-file-name file-name))
      (push `(,current-pos ,file-name) evil-jumper--list))))

(defun evil-jumper--set-jump ()
  ;; clear out intermediary jumps when a new one is set
  (nbutlast evil-jumper--list evil-jumper--idx)
  (setq evil-jumper--idx -1)
  (evil-jumper--push))

(evil-define-motion evil-jumper/backward (count)
  (let ((count (or count 1)))
    (evil-motion-loop (nil count)
      (when (= evil-jumper--idx -1)
        (incf evil-jumper--idx)
        (evil-jumper--push))
      (evil-jumper--jump-to-index (+ evil-jumper--idx 1)))))

(evil-define-motion evil-jumper/forward (count)
  (let ((count (or count 1)))
    (evil-motion-loop (nil count)
      (evil-jumper--jump-to-index (- evil-jumper--idx 1)))))

(defadvice evil-set-jump (after advice-for-evil-set-jump activate)
  (evil-jumper--set-jump))

(defadvice switch-to-buffer (after advice-for-switch-to-buffer activate)
  (unless evil-jumper--jumping
    (evil-jumper--set-jump)))

(define-key evil-motion-state-map (kbd "C-o") 'evil-jumper/backward)
(define-key evil-motion-state-map (kbd "C-i") 'evil-jumper/forward)

(provide 'evil-jumper)
