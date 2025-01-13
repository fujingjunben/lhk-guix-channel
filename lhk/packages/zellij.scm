(define-module (lhk packages zellij)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:))

(define-public zellij
  (package
   (name "zellij")
   (version "0.41.2")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/zellij-org/zellij/releases/download/v"
                                version "/" name "-x86_64-unknown-linux-musl.tar.gz"))
            (sha256
             (base32 "0y3cpy20g984jrz8gnc6sqjskfwmfjngd617bksvm9fq2yl23hxi"))))
   (build-system copy-build-system)
   (supported-systems '("x86_64-linux"))
   (arguments
    `(#:install-plan '(("zellij" "bin/"))
      #:phases
      (modify-phases %standard-phases
                     ;; (replace 'unpack
                     ;;          (lambda* (#:key source #:allow-other-keys)
                     ;;                   (let ((target "mihomo-linux-amd64.gz"))
                     ;;                     ;; Copy the source to the current directory
                     ;;                     (copy-file source target)
                     ;;                     ;; Extract the file
                     ;;                     (invoke "gunzip" target))))
                     (add-after 'install 'set-executable-permission
                                (lambda* (#:key outputs #:allow-other-keys)
                                         (let* ((out (assoc-ref outputs "out"))
                                                (binary (string-append out "/bin/zellij")))
                                           (chmod binary #o755)
                                           #t))))))
   (home-page "https://zellij.dev")
   (synopsis "A terminal workspace with batteries included")
   (description "A terminal workspace with batteries included")
   (license licenses:mpl2.0)))
zellij

   
