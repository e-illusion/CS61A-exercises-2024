(define (curry-cook formals body)
(if (null? (cdr formals))
  (list 'lambda (list (car formals)) body) 
  (list 'lambda (list (car formals)) 
    (curry-cook (cdr formals) body))))

(define (curry-consume curry args)
(if (null? args) curry
   (let ((result (curry (car args))))
     (curry-consume result (cdr args)))))


(define-macro (switch expr options)
  (switch-to-cond (list 'switch expr options)))

(define (switch-to-cond switch-expr)
  (cons 'cond
        (map (lambda (option)
               (cons (list 'equal? (car (cdr switch-expr)) (car option)) (cdr option)))
             (car (cdr (cdr switch-expr))))))
