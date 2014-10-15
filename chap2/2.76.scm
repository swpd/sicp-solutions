; In order to add new types:
; explicit dispatch:
;   we need to add an additional clause to every generic procedure.
; data-directed:
;   we need to add install the corresponding operations on this new types into
;   the table.
; message-passing:
;   no extra work except the implementation of the new type itself.
;
; In order to add new operations:
; explicit dispatch:
;   we need to add a new procedure that contains the dispatch for all available
;   types.
; data-directed:
;   we need to add a new procedure to each type and then install them into the
;   the table.
; message-passing:
;   we need to add a new dispatch clause for the new operation of each type.
;
; For a system in which new types must often be added, message-passing is most
; appropriate.
; For a system in which new operations must often be added, data-directed is most
; appropriate.
