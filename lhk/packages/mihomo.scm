(define-module (lhk packages mihomo)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix licenses:))

(define-public mihomo
  (package
   (name "mihomo")
   (version "1.19.1")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/MetaCubeX/mihomo/releases/download/v"
                                version "/" name "-linux-amd64-v" version ".gz"))
            (sha256
             (base32 "0g1qzvxnvbxhpf88ck898yh8avbc2n80jmfj9b713w90sdndj8bi"))))
   (build-system copy-build-system)
   (supported-systems '("x86_64-linux"))
   (arguments
    `(#:install-plan '(("mihomo-linux-amd64" "bin/mihomo"))
      #:phases
      (modify-phases %standard-phases
                     (replace 'unpack
                              (lambda* (#:key source #:allow-other-keys)
                                       (let ((target "mihomo-linux-amd64.gz"))
                                         ;; Copy the source to the current directory
                                         (copy-file source target)
                                         ;; Extract the file
                                         (invoke "gunzip" target))))
                     (add-after 'install 'set-executable-permission
                                (lambda* (#:key outputs #:allow-other-keys)
                                         (let* ((out (assoc-ref outputs "out"))
                                                (binary (string-append out "/bin/mihomo")))
                                           (chmod binary #o755)
                                           #t))))))
   (home-page "https://wiki.metacubex.one")
   (synopsis "A simple Python Pydantic model for Honkai: Star Rail parsed data from the Mihomo API")
   (description "A simple Python Pydantic model for Honkai: Star Rail parsed data from the Mihomo API")
   (license licenses:mpl2.0)))
mihomo

   
