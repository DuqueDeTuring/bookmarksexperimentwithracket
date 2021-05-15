#lang racket

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
  (string-join (map (lambda (item)
                      (string-append "* " item "\n"))
                    (map md-bookmark bmrks))))

(define (export filename data)
  (define out (open-output-file filename #:exists 'replace))
  (display data out)
  (close-output-port out))

(define (generate)
  
  (b "Ursula K. Le Guin" (u "https://www.ursulakleguin.com/home/") '(watchdog ❤) "web home")
  (b "Category Theory" (u "https://plato.stanford.edu/entries/category-theory/") '(sep category-theory cs) "")
  (b "dmitry.gr"(u "https://dmitry.gr") '(electronics re blog watchdog) "")
  (b "Saleae Logic" (u "https://www.saleae.com/") '(products electronics reverse-engineering) "logic analyzer recommended in https://dmitry.gr/?r=05.Projects&proj=30.%20Reverse%20Engineering%20an%20Unknown%20Microcontroller")
  (b "gofeed" (u "https://github.com/mmcdole/gofeed") '(code rss github) "rss feed reader in go")
  (b "Send My: Arbitrary data transmission via Apple's Find My network" (u "https://positive.security/blog/send-my") '(re protocols privacy security article) "")
  (b "3 Simple Ways of Programming an ESP8266 12X Module" (u "https://www.instructables.com/3-Simple-Ways-of-Programming-an-ESP8266-12X-Module/") '(electronics howto) "")
  (b "Getting Started with ESP8266 WiFi Transceiver (Review)" (u "https://randomnerdtutorials.com/getting-started-with-esp8266-wifi-transceiver-review/") '(electronics howto) "")
  (b "How to Flash ESP-01 Firmware to the Improved SDK v2.0.0" (u "https://www.allaboutcircuits.com/projects/flashing-the-ESP-01-firmware-to-SDK-v2.0.0-is-easier-now/") '(electronics howto) "")
  (b "Category Theory: Lecture Notes And Online Books" (u "https://www.logicmatters.net/categories/") '(cs category-theory) "")
  (b "Terminal and initial objects 1" (u "https://youtu.be/yeQcmxM2e5I") '(cs category-theory video) "")
  (b "Category theory for the working hacker by Philip Wadler " (u "https://youtu.be/V10hzjgoklA") '(cs category-theory video ❤) "")


  (export
   "readme.md"
   ; "bookmarks.html"
   ;   (string-append "<html lang='en'><head> <meta charset='utf-8' /><meta name='viewport' content='width=device-width, initial-scale=1' /><title>My Bookmarks</title></head><body>"
   ;                  (html-bookmarks bookmarks)
   ;                  "</body></html>")
   (string-append "# My bookmarks\n\n "
                  (md-bookmarks bookmarks))
   ))
