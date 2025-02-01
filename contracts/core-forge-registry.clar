;; CoreForge Registry Contract
;; Tracks all applications created through the platform

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-not-owner (err u100))
(define-constant err-already-registered (err u101))

;; Data structures
(define-map registered-apps 
  principal 
  {
    name: (string-ascii 64),
    owner: principal,
    created-at: uint,
    status: (string-ascii 12)
  }
)

(define-map app-metadata
  principal
  {
    description: (string-utf8 256),
    website: (optional (string-ascii 128)),
    repository: (optional (string-ascii 128))
  }
)

;; Public functions
(define-public (register-app (app-principal principal) (name (string-ascii 64)))
  (let ((caller tx-sender))
    (asserts! (is-eq caller contract-owner) err-not-owner)
    (asserts! (is-none (map-get? registered-apps app-principal)) err-already-registered)
    
    (ok (map-set registered-apps 
      app-principal
      {
        name: name,
        owner: caller,
        created-at: block-height,
        status: "active"
      }
    ))
  )
)

;; Read only functions
(define-read-only (get-app-details (app-principal principal))
  (ok (map-get? registered-apps app-principal))
)
