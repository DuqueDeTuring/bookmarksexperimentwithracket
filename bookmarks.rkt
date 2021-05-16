#lang racket
(require "database.rkt")
(require "bmrkdef.rkt")

#|
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
 |#

(define (html-bookmark bmrk)
  (string-append "<a href=\"" (bookmark-url bmrk) "\">"
                 (bookmark-title bmrk)
                 "</a>" ))

(define (html-bookmarks bmrks)
  (string-append "<ul>"
                 (string-join (map (lambda (item)
                                     (string-append "<li>" item "</li>"))
                                   (map html-bookmark bmrks)))
                 "</ul>"))


(define (md-bookmark bmrk)
  (string-append "[" (bookmark-title bmrk) "](" (bookmark-url bmrk) ")" ))
  
(define (md-bookmarks bmrks)
  (define per-tag
    (map (lambda (t)
           ;(define tname (hash-ref tags-table t))
           (string-join (cons (string-append "## " (symbol->string t) "\n")
                          (map (lambda (item)
                                 (string-append "* " item "\n"))
                               (map md-bookmark (hash-ref tags-table t))))))
           
         ; ))
         (hash-keys tags-table)
         ;'(howto)
         ))
  
  #|(string-join (map (lambda (item)
                      (string-append "* " item "\n"))
                    (map md-bookmark bmrks))
               per-tag)|#
               
  per-tag
  )

(define (export filename data)
  (define out (open-output-file filename #:exists 'replace))
  (display data out)
  (close-output-port out))

(define (generate)
  (load-db)
  (print (hash-keys tags-table))
  (print "\n")
  (export
   "readme.md"
   ; "bookmarks.html"
   ;   (string-append "<html lang='en'><head> <meta charset='utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1' /><title>My Bookmarks</title></head><body>"
   ;                  (html-bookmarks bookmarks)
   ;                  "</body></html>")
   (string-join (cons "# My bookmarks\n\n "
                   (md-bookmarks bookmarks)))
   ))
