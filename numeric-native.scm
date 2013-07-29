;;; numeric-native.scm --- Native numeric types, via Guile's FFI module.

;; Copyright (C) 2013  Taylan Ulrich B.

;; Author: Taylan Ulrich B. <taylanbayirli@gmail.com>
;; Keywords: ffi struct bytevector bytestructure numeric native

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This module defines descriptors for platform-specific numeric types, as made
;; possible by Guile's FFI module.


;;; Code:

(define-module (bytestructures numeric-native)
  #:export
  (
   short unsigned-short int unsigned-int long unsigned-long
   size_t ssize_t ptrdiff_t
   ))

(use-modules (bytestructures numeric)
             ((system foreign) #:select (sizeof)))

(let-syntax ((define-signed-native-synonyms
               (syntax-rules ()
                 ((_ name ...)
                  (begin
                    (define name
                      (case (sizeof (@ (system foreign) name))
                        ((1) int8)
                        ((2) int16)
                        ((4) int32)
                        ((8) int64)))
                    ...)))))
  (define-signed-native-synonyms
    short int long ssize_t ptrdiff_t))

(let-syntax ((define-unsigned-native-synonyms
               (syntax-rules ()
                 ((_ name ...)
                  (begin
                    (define name
                      (case (sizeof (@ (system foreign) name))
                        ((1) uint8)
                        ((2) uint16)
                        ((4) uint32)
                        ((8) uint64)))
                    ...)))))
  (define-unsigned-native-synonyms
    unsigned-short unsigned-int unsigned-long size_t))

;;; numeric-native.scm ends here