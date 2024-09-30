((org-mode . ((eval . (progn
                        (message "Debug: Starting Org mode configuration")

                        ;; Set up package management
                        (require 'package)
                        (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
                        (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
                        (package-initialize)

                        ;; Function to ensure a package is installed
                        (defun ensure-package-installed (package)
                          "Ensure that PACKAGE is installed."
                          (unless (package-installed-p package)
                            (condition-case nil
                                (package-install package)
                              (error
                               (package-refresh-contents)
                               (package-install package)))))

                        ;; List of required packages
                        (dolist (pkg '(compat org htmlize magit))
                          (ensure-package-installed pkg))

                        (message "Debug: Required packages checked and installed if necessary")

                        ;; Disable the startup screen
                        (setq inhibit-startup-screen t)
                        (message "Debug: Startup screen disabled")

                        ;; Function to export Org to HTML and open preview
                        (defun refresh-org-html-preview ()
                          "Export Org to HTML, close existing preview, and open a new one."
                          (message "Debug: Entering refresh-org-html-preview function")
                          (when (and (eq major-mode 'org-mode) (buffer-file-name))
                            (let* ((org-file (expand-file-name (buffer-file-name)))
                                   (html-file (concat (file-name-sans-extension org-file) ".html")))
                              (message "Debug: org-file: %s" org-file)
                              (message "Debug: html-file: %s" html-file)
                              (message "Debug: Attempting to export %s to %s" org-file html-file)
                              (condition-case err
                                  (progn
                                    ;; Close existing eww window if it exists
                                    (when (get-buffer-window "*eww*")
                                      (delete-window (get-buffer-window "*eww*"))
                                      (message "Debug: Closed existing eww window"))

                                    ;; Export to HTML
                                    (org-html-export-to-html nil nil nil t)
                                    (message "Debug: Successfully exported %s to %s" org-file html-file)

                                    ;; Open new preview
                                    (split-window-right)
                                    (other-window 1)
                                    (eww-open-file html-file)
                                    (other-window 1)
                                    (message "Debug: Opened new HTML preview in eww"))
                                (error (message "Debug: Error during refresh: %s" err))))))

                        ;; Function to maximize the window
                        (defun maximize-frame ()
                          "Maximize the current frame"
                          (interactive)
                          (set-frame-parameter nil 'fullscreen 'maximized)
                          (message "Debug: Window maximized"))

                        ;; Add functions to be run after file is loaded
                        (add-hook 'find-file-hook 
                                  (lambda ()
                                    (when (eq major-mode 'org-mode)
                                      (run-at-time "0.5 sec" nil 'maximize-frame)
                                      (run-at-time "1 sec" nil 'refresh-org-html-preview))))

                        ;; Add function to update preview on save
                        (add-hook 'after-save-hook 
                                  (lambda ()
                                    (when (eq major-mode 'org-mode)
                                      (refresh-org-html-preview))))

                        (message "Debug: Added hooks for maximization, initial preview, and refresh-on-save")

                        ;; Message to confirm loading
                        (message "Debug: Org mode configuration loaded"))))))
