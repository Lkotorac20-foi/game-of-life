(ql:quickload "split-sequence")


(defun make-grid (rows cols)
  "Kreira prazni grid popunjen nulama."
  (make-array (list rows cols) :initial-element 0))

(defun set-cell (grid row col value)
  "Set the value of a cell in the grid."
  (setf (aref grid row col) value))

(defun get-cell (grid row col)
  "Get the value of a cell in the grid."
  (aref grid row col))

(defun print-grid (grid)
  "Print the grid with '.' for dead cells and 'X' for live cells."
  (loop for i from 0 below (array-dimension grid 0) do
        (format t "~{~a ~}~%"
                (loop for j from 0 below (array-dimension grid 1)
                      collect (if (= (aref grid i j) 1) "X" ".")))))

(defun count-neighbors (grid row col)
  "COunt the number of living neighbors of a cell in the grid."
  (let ((rows (array-dimension grid 0))
	(cols (array-dimension grid 1))
	(count 0))
    (loop for i from (max 0 (- row 1)) to (min (1- rows) (+ row 1)) do
      (loop for j from (max 0 (- col 1)) to (min (1- cols) (+ col 1)) do
	(unless (and (= i row) (= j col)) ; Ne brojimo samo celiju
	  (incf count (aref grid i j)))))
    count))

(defun next-generation (grid)
  "Calculate the next generation of the grid."
  (let* ((rows (array-dimension grid 0))
	 (cols (array-dimension grid 1))
	 (new-grid (make-grid rows cols)))
    (loop for i from 0 below rows do
      (loop for j from 0 below cols do
	(let ((neighbors (count-neighbors grid i j)))
	  (set-cell new-grid i j
		    (if (= 1 (aref grid i j)) ;Ako je celija ziva
			(if (or (= neighbors 2) (= neighbors 3)) 1 0)
			(if (= neighbors 3) 1 0))))))
    new-grid))

(defun run-console-game ()
  "Run the Game of Life in a console-based interface."
  (format t "Welcome to the Game of Life!~%")
  (loop
    ;; Inicijalizacija mreže
    (let (grid)
      ;; Unos dimenzija mreže
      (loop
        (format t "Enter grid size (rows cols): ")
        (let ((input (read-line)))
          (handler-case
              (let ((dimensions (map 'list #'parse-integer
                                     (split-sequence:split-sequence #\Space input :remove-empty-subseqs t))))
                (if (= (length dimensions) 2)
                    (progn
                      (setf grid (make-grid (first dimensions) (second dimensions)))
                      (return))
                    (format t "Invalid input. Please enter two integers separated by a space.~%")))
            (error ()
              (format t "Invalid input. Please enter two positive integers separated by a space.~%")))))
      ;; Unos početnih živih ćelija
      (format t "Enter live cell coordinates as row,col (e.g., 1,2). Type 'done' to finish.~%")
      (loop
        (let ((input (read-line)))
          (if (string= input "done")
              (return)
              (handler-case
                  (let ((coordinates (map 'list #'parse-integer
                                          (split-sequence:split-sequence #\, input :remove-empty-subseqs t))))
                    (if (= (length coordinates) 2)
                        (let ((row (first coordinates))
                              (col (second coordinates)))
                          (if (and (>= row 0) (< row (array-dimension grid 0))
                                   (>= col 0) (< col (array-dimension grid 1)))
                              (set-cell grid row col 1)
                              (format t "Coordinates out of bounds. Try again.~%")))
                        (format t "Invalid input. Please enter coordinates as row,col.~%")))
                (error ()
                  (format t "Invalid input. Please enter coordinates as row,col.~%"))))))
      ;; Pokretanje simulacije
      (format t "Simulation starting... Press 'q' to quit after any generation.~%")
      (loop
        (print-grid grid)
        (sleep 1) ; Pauza od 1 sekunde
        (format t "~%")
        ;; Pitanje korisniku nakon svake generacije
        (format t "Press Enter to continue or 'q' to quit: ")
        (let ((response (read-line)))
          (when (string= response "q")
            (return))) ; Prekida petlju ako korisnik unese "q"
        ;; Generacija sljedeće mreže
        (setf grid (next-generation grid))))
    ;; Nakon završetka igre, pita korisnika za ponovno pokretanje
    (format t "Do you want to play again? (y/n): ")
    (let ((response (read-line)))
      (unless (string= response "y")
        (return))))) ; Prekida glavnu petlju ako korisnik unese bilo što osim "y"



            
        
                      




         
       
