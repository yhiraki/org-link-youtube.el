;;; package --- Summary                              -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:

(require 'browse-url)
(require 'ol)
(require 'ol-info)
(require 'ox)
(require 'url)

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
  (browse-url (format "https://www.youtube.com/watch?v=%s" path)))

(defvar org-link-youtube-export-html-format
  (concat "<iframe width=\"440\""
          " height=\"335\""
          " src=\"https://www.youtube.com/embed/%s\""
          " frameborder=\"0\""
          " allowfullscreen>%s</iframe>"))

(defun org-link-youtube-export (path desc backend _com)
  "Doc."
  (pcase backend
    ('html (format org-link-youtube-export-html-format path desc))
    ('md (format "[%s](https://www.yotube.com/watch?v=%s)" desc path))
    (_ (format "%s - %s" desc path)))
  )

(org-link-set-parameters
 "youtube"
 :follow #'org-link-youtube-follow-link
 :export #'org-link-youtube-export)

(provide 'org-link-youtube)

;;; org-link-youtube.el ends here
