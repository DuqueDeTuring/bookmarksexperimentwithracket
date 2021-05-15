#lang racket


(struct tag (name) #:transparent)

(struct bookmark (title url tags) #:transparent)

(define bookmarks '())


(define (b title url tags)
  (define newbk (bookmark title url (map tag tags)))
  (set! bookmarks (cons newbk bookmarks)))

(define (u a)
  a)

(define (t tl)
  tl)

(define (start)

  
  (b "Ursula K. Le Guin" (u "https://www.ursulakleguin.com/home/") '(watchdog ❤))
  (b "Category Theory" (u "https://plato.stanford.edu/entries/category-theory/") '(sep category-theory cs))

  bookmarks)