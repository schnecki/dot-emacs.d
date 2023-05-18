;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++ Configuration for EDE project management ++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(global-ede-mode t)

(require 'cedet)
(require 'eieio)
(require 'eieio-speedbar)
(require 'eieio-opt)
(require 'eieio-base)
(require 'ede/source)
(require 'ede/base)
(require 'ede/auto)
(require 'ede/proj)
(require 'ede/proj-archive)
(require 'ede/proj-aux)
(require 'ede/proj-comp)
(require 'ede/proj-elisp)
(require 'ede/proj-info)
(require 'ede/proj-misc)
(require 'ede/proj-obj)
(require 'ede/proj-prog)
(require 'ede/proj-scheme)
(require 'ede/proj-shared)


;; (require 'ede/detect)
(require 'ede/dired)
(require 'ede/make)

(load "ede/loaddefs" nil 'nomessage)

(declare-function ede-commit-project "ede/custom")
(declare-function ede-convert-path "ede/files")
(declare-function ede-directory-get-open-project "ede/files")
(declare-function ede-directory-get-toplevel-open-project "ede/files")
(declare-function ede-directory-project-p "ede/files")
(declare-function ede-find-subproject-for-directory "ede/files")
(declare-function ede-project-directory-remove-hash "ede/files")
(declare-function ede-toplevel "ede/base")
(declare-function ede-toplevel-project "ede/files")
(declare-function ede-up-directory "ede/files")
(declare-function semantic-lex-make-spp-table "semantic/lex-spp")

(defconst ede-version "2.0"
  "Current version of the Emacs EDE.")


(add-hook 'find-file-hook 'ede-turn-on-hook)

