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

(define (export html)
  (define out (open-output-file "bookmarks.html" #:exists 'replace))
  (display html out)
  (close-output-port out))

(define (start)
  
  (b "Ursula K. Le Guin" (u "https://www.ursulakleguin.com/home/") '(watchdog ❤))
  (b "Category Theory" (u "https://plato.stanford.edu/entries/category-theory/") '(sep category-theory cs))
  (b "dmitry.gr"(u "https://dmitry.gr") '(electronics re blog watchdog))

  (export
   (string-append "<html lang='en'><head> <meta charset='utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1' /><title>My Bookmarks</title></head><body>"
                  (html-bookmarks bookmarks)
                  "</body></html>")))
