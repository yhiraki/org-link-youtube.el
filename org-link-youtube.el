;;; package --- Summary                              -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:

(require 'ol)
(require 'url)
(require 'browse-url)

(defun org-link-youtube-get-video-id (url)
  "Get youtube video id from URL."
  (let* ((u (url-generic-parse-url url))
         (host (url-host u))
         (path (url-filename u))
         (youtube? (or (string-suffix-p "youtube.com" host)))
         (vid (when youtube?
                (string-match "/watch?.*v=\\(.*\\)" path)
                (match-string 1 path))))
    vid))

(defun org-link-youtube-follow-link (path)
  "Open youtube PATH."
  (if (string-match "^https://" path)
      (browse-url path)
    (browse-url (format "https://youtube.com/watch?v=%s" path))))

(defvar org-link-youtube-export-html-format
  (concat "<iframe width=\"440\""
          " height=\"335\""
          " src=\"https://www.youtube.com/embed/%s\""
          " frameborder=\"0\""
          " allowfullscreen>%s</iframe>"))

(defun org-link-youtube-export (path desc backend com)
  "Doc."
  (let* ((vid (org-link-youtube-get-video-id path))
         (vid (if vid vid path)))
    (cond
     ((eq 'html backend)
      (format org-link-youtube-export-html-format
              vid ""))
     (t
      (org-export backend )
      "hoge"))))

(org-link-set-parameters
 "youtube"
 :follow #'org-link-youtube-follow-link
 :export #'org-link-youtube-export)

(provide 'org-link-youtube)

;;; org-link-youtube.el ends here
