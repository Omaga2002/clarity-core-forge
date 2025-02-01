;; CoreForge Factory Contract
;; Deploys new applications and manages their lifecycle

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-not-authorized (err u100))

;; Dependencies
(define-trait app-interface
  (
    (initialize (principal) (response bool uint))
    (get-owner () (response principal uint))
  )
)

;; State
(define-map authorized-templates
  principal 
  bool
)

;; Public functions
(define-public (create-app (template-principal <app-interface>) (app-name (string-ascii 64)))
  (let 
    (
      (caller tx-sender)
      (is-authorized (default-to false (map-get? authorized-templates template-principal)))
    )
    
    (asserts! is-authorized err-not-authorized)
    
    ;; Initialize new app
    (contract-call? template-principal initialize caller)
  )
)

;; Admin functions
(define-public (authorize-template (template-principal principal))
  (let ((caller tx-sender))
    (asserts! (is-eq caller contract-owner) err-not-authorized)
    (ok (map-set authorized-templates template-principal true))
  )
)
