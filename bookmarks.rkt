#lang racket
(require "database.rkt")
(require "bmrkdef.rkt")

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
  (string-append "[" (bookmark-title bmrk) "](" (bookmark-url bmrk) ") *tags:* "
                 (string-join (map (lambda (t)
                        (define name (symbol->string (tag-name t)))
                        (string-append "[" name "](#" name ")"))
                      (bookmark-tags bmrk)))))
  
(define (md-bookmarks bmrks)
  (define per-tag
    (map (lambda (t)
           (string-join (cons (string-append "## " (symbol->string t) "\n")
                          (map (lambda (item)
                                 (string-append "* " item "\n"))
                               (map md-bookmark (hash-ref tags-table t))))))
           
         (sort (hash-keys tags-table)
               (lambda (a b)
                 (string<? (symbol->string a)
                           (symbol->string b))))))
  per-tag)

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
                   (md-bookmarks bookmarks)))))
