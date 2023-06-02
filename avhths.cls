%% This class provides the style according to the AvH Facharbeit standards.
%% This class is called `avhths` as a Facharbeit is basically a little thesis
%% It was initially developed during a LaTeX course at our school
%% It is recommended to use biblatex in conjunction with this document class.
%% The class itself dosen't provide anything biblatex specific, however there is
%% a bibliography style for biblatex available
%%
%% Authors: Moritz Sokoll, Fiete Arendt, Henning Mehnert, Johan Rosenthal

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{avhths}[2023/04/14 AvH Facharbeit]

\RequirePackage{xkeyval}

\newcommand{\thesubject}{}


% different subjects
\define@key{avhths.cls}{subject}[]{
  \renewcommand{\thesubject}{#1}
}
\ExecuteOptions{subject}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptionsX\relax
\LoadClass[
    fontsize=12pt,
    listof=totoc,
    bibliography=totoc,
    usegeometry=true,
]{scrartcl}

% page layout
\RequirePackage[left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm]{geometry}
\RequirePackage{scrlayer-scrpage}
\RequirePackage[onehalfspacing]{setspace}
\RequirePackage{ifthen}
% defining a custom pagestyle makes it easier to base other documents on this class
\deftriplepagestyle{avhpagestyle}{}{-- {\pagemark} --}{}{}{}{}

\pagestyle{avhpagestyle}

% titlepage
\def\title#1{\gdef\@title{#1}}
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\author#1{\gdef\@author{#1}}
\def\date#1{\gdef\@date{#1}}
\def\subject#1{\gdef\@subject{#1}}
\def\institution#1{\gdef\@institution{#1}}
\def\location#1{\gdef\@location{#1}}
\def\instructor#1{\gdef\@instructor{#1}}
\def\grade#1{\gdef\@grade{#1}}
\def\gradesuffix#1{\gdef\@gradesuffix{#1}}
\def\gender#1{\gdef\@gender{#1}}
\def\essay#1{\gdef\@essay{#1}}
\def\schoolyear#1{\gdef\@schoolyear{#1}}

\renewcommand{\maketitle}{
  \begin{titlepage}
    \centering\textbf{\sffamily\huge \@title}

    \vspace{3cm}

    \centering\sffamily\normalsize {\@essay} der Klasse {\@grade}

    \centering\sffamily im Schuljahr {\@schoolyear}

    \vspace{2cm}

    \centering\sffamily am Alexander-von-Humboldt-Gymnasium

    \vspace{2cm}

    \centering\sffamily eingereicht von

    \centering\sffamily\large {\@author}, Klasse {\@grade\@gradesuffix}

    \vspace{2cm}

    \centering\sffamily Im Fach {\@subject}

    \vspace{2cm}

    \centering\sffamily\normalsize {\ifthenelse{\equal{\@gender}{m}}{Unterrichtender Fachlehrer}{Unterrichtende Fachlehrerin}}: {\@instructor}

    \vspace{4cm}

    \centering\sffamily {\@location}, {\the\year{}}
  \end{titlepage}
}
% the \@title, etc. commands are available after the maketitle command has been called
\subject{\thesubject}

\newcommand{\subjectcode}[2]{
  \ifthenelse{\equal{\thesubject}{#1}}{#2}{}
}

\subjectcode{math}{
  \RequirePackage{amsmath}
  \RequirePackage{amssymb}
  \RequirePackage{gensymb}
  \RequirePackage{amsthm}

  \newtheorem{theorem}{Theorem}
  \newtheorem{lemma}{Lemma}
  \newtheorem{corollary}{Folgerung}

  \theoremstyle{definition}
  \newtheorem{definition}{Definition}

  \theoremstyle{remark}
  \newtheorem{remark}{Bemerkung}

  \theoremstyle{default}

  \subject{Mathematik}
}
\subjectcode{ger}{\subject{Deutsch}}
\subjectcode{eng}{\subject{Englisch}}
\subjectcode{history}{\subject{Geschichte}}
\subjectcode{geo}{\subject{Geographie}}
\subjectcode{phys}{
  \subject{Physik}\RequirePackage{physics}\RequirePackage{siunitx}
}
\subjectcode{chem}{\subject{Chemie}}
\subjectcode{bio}{\subject{Biologie}}
\subjectcode{arts}{\subject{Kunst}}
\subjectcode{music}{\subject{Musik}}
\subjectcode{phil}{\subject{Philosophie}}
\subjectcode{reli}{\subject{Religion}}
\subjectcode{econ}{\subject{Wirtschaft}}
\subjectcode{soc}{\subject{Sozialkunde}}
\subjectcode{inf}{
  \subject{Informatik}
  \RequirePackage{listings}
}
% default values for all title page commands
\title{}
\subtitle{}
\author{}
\date{\today}
\institution{}
\location{}
\instructor{}
\gender{m}
\essay{Facharbeit}
\grade{1}
\gradesuffix{a}
\schoolyear{\the\year{}}

% table of contents
%\newcommand{\oldtoc}{\tableofcontents}
\renewcommand{\tableofcontents}{%
  \begingroup
    \let\if@dynlist\if@tocleft
    \expandafter\listoftoc\expandafter{\ext@toc}%
  \endgroup
  \newpage
}

% the declaration of independence for your document (not to be confused with the declaration of independence by the united states)
% it is a written declaration that you worked independently on your thesis
\newcommand{\printdeclofindep}{
  \cleardoublepage

  \section*{Selbstst{\"a}ndigkeitserkl{\"a}rung}
  \addsectiontocentry{}{Selbstst{\"a}ndigkeitserkl{\"a}rung}

  ``Ich erkl{\"a}re, dass ich die Facharbeit ohne fremde Hilfe angefertigt habe und
  nur die im Literaturverzeichnis angef{\"u}hrten Quellen und Hilfsmittel benutzt
  habe. Alle Stellen, die w{\"o}rtlich oder Sinngem{\"a}{\ss}, aus Quellen entnommen wurden,
  sind all solche gekennzeichnet.''

  \medskip

  \noindent\emph{Greifswald, den {\@date}\hfill Unterschrift des Sch{\"u}lers:\hspace{2cm}}
}