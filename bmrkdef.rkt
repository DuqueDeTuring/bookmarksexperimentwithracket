#lang racket
(provide b u bookmark-url bookmark-title bookmarks) 



(struct tag (name) #:transparent)

(struct bookmark (title url tags comment) #:transparent)

(define bookmarks '())

(define (b title url tags comment)
  (define newbk (bookmark title url (map tag tags) comment))
  (set! bookmarks (cons newbk bookmarks)))

(define (u a)
  a)

(define (t tl)
  tl)
