#lang racket
(provide b u bookmark-url bookmark-title bookmarks tags-table tag-name tag-bks) 



(define tags-table (make-hash))

(struct tag (name bks) #:transparent)

(struct bookmark (title url tags comment) #:transparent)

(define bookmarks '())

(define (b title url tags comment)
  (define ts (map (lambda (t)
                    (tag t '()))
                  tags))

  (define newbk (bookmark title url ts comment))
  (map (lambda (t)
         (hash-set! tags-table (tag-name t) (cons newbk (hash-ref! tags-table (tag-name t) '()))))
       ts)
  (set! bookmarks (cons newbk bookmarks)))

(define (u a)
  a)

(define (t tl)
  tl)
