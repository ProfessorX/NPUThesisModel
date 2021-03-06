% !Mode:: "TeX:UTF-8"
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{NPUthesis}[2013/05/31 2.0.0 NPU Thesis Template]
%------待解决------
%chapter不另起一页，直接接在上文的后面。
%------待解决------

%------chstyle------
\newif\ifchsstyle\chsstyletrue
\DeclareOption{chsstyle}{\chsstyletrue}
\DeclareOption{nochsstyle}{\chsstylefalse}
%------chstyle------

%------print------
\newif\ifprint\printfalse
\newif\ifdprint\dprintfalse

\DeclareOption{noprint}{\dprintfalse\printfalse}
\DeclareOption{print}{\printtrue}
\DeclareOption{dprint}{\dprinttrue\printtrue}
\ProcessOptions\relax
\ifdprint\relax\else
\PassOptionsToClass{openany}{book}
\fi
%------print------

\LoadClass[a4paper, 12pt]{book}
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{ctexcap}}
\ExecuteOptions{noprint,chsstyle} %默认参数
\ProcessOptions\relax

%------中文支持------
\RequirePackage[noindent,nocap,UTF8]{ctexcap}
\RequirePackage{xeCJK}
%----字体名
\RequirePackage{ifpdf,ifxetex}
\ifpdf
\newcommand{\nwpulogo}{\heiti}
\else
\newCJKfontfamily{\nwpulogo}{nwpulogo}
\fi
%------中文支持------

%------行距------
\linespread{1.25}
\addtolength{\parskip}{.3em}
%------行距------

%------页面设置------
\ifdprint
	\newcommand{\GeoOptions}{left=3.75cm, right=2.75cm, top=3cm, bottom=3cm}
\else
	\newcommand{\GeoOptions}{left=2.75cm, right=2.75cm, top=3cm, bottom=3cm}
\fi
\RequirePackage[\GeoOptions]{geometry}
%------页面设置------

%------页眉页脚------
\RequirePackage{fancyhdr}
%----清除设置----
\pagestyle{fancyplain}
\fancyhf{}
%----清除设置----
%----页眉划线----
%\renewcommand{\headrulewidth}{\textwidth}
%\renewcommand{\headwidth}{.5pt}

\newcommand{\makeheadrule}{%
\makebox[0pt][l]{\rule[.7\baselineskip]{\headwidth}{0.5pt}}%
%\rule[0.85\baselineskip]{\headwidth}{1.5pt}\vskip-.8\baselineskip
}

\makeatletter
\renewcommand{\headrule}{%
{\if@fancyplain\let\headrulewidth\plainheadrulewidth\fi
\makeheadrule}}
\makeatother
%----页眉划线----
%----眉脚内容----
\pagestyle{fancy}
\fancyhf{}
\ifchsstyle
% They require \songti, but I (Abraham) think \heiti is better, too.
\chead{\zihao{5}{\nwpulogo{}西北工业大学}~\heiti{}本科毕业设计论文}
\else
\chead{\small Northwestern Polytechnic University Bachelor Thesis}
\fi
\cfoot{--{~\thepage~}--}
%----眉脚内容----
%------页眉页脚------

%------数学支持------
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{amsbsy}
\RequirePackage{bm}
\RequirePackage{mathrsfs}
% For these commands, it's better to "new" than "renew". Good Job.
\newcommand*{\me}{\ensuremath{\mathrm{e}}}				%自然对数的底
\newcommand*{\mi}{\ensuremath{\mathrm{i}}}				%虚数单位
\newcommand*{\dif}{\ensuremath{\,\mathrm{d}}}			%微分算子
\DeclareMathAlphabet{\mathsfsl}{OT1}{cmss}{m}{sl}
\newcommand*{\VEC}[1]{\ensuremath{\boldsymbol{#1}}}		%向量
\newcommand*{\MATRIX}[1]{\ensuremath{\mathsfsl{#1}}}	%矩阵名称
\newcommand*{\TENSOR}[1]{\ensuremath{\mathsfsl{#1}}}	%张量名称
\newcommand*{\HUA}[1]{\ensuremath{\mathscr{{#1}}}} 		%输出花体字母
\newcommand*{\SHUANG}[1]{\ensuremath{\mathbb{{#1}}}}	%输出双线字母
% Modify the code below if you want to numbering equations within sections.
\numberwithin{equation}{chapter}						%公式编号随chapter变化
\renewcommand{\theequation}{\thechapter{}--\arabic{equation}}
%------数学支持------

%------图表支持------
\RequirePackage{graphicx}
%----图档搜索路径----
\graphicspath{{figures/}{figure/}{pictures/}{picture/}{pic/}{pics/}}
%----图档搜索路径----
\RequirePackage{booktabs}
%%----表格行距----
%\renewcommand\arraystretch{1.3}
%%----表格行距----
%----编号----
\RequirePackage{amsmath}
\numberwithin{figure}{chapter}
\renewcommand{\thefigure}{\thechapter{}--\arabic{figure}}
\numberwithin{table}{chapter}
\renewcommand{\thetable}{\thechapter{}--\arabic{table}}
%----编号----
%----不浮动----
\makeatletter
\newcommand{\figcaption}{\def\@captype{figure}\caption}
\newcommand{\tabcaption}{\def\@captype{table}\caption}
\makeatother
%----不浮动----
%------图表支持------

%------交叉引用------
\RequirePackage{hyperref}
\hypersetup{unicode}
\hypersetup{colorlinks=true}
\hypersetup{linkcolor=black}
\ifprint
	\hypersetup{allcolors=black}
\else\relax\fi
%------交叉引用------

%------参考文献------
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}  % Some bugs. I can testify.
% newcommand{\upcite}[1]{$^{\mbox{\scriptsize \cite{#1}}}$}
%------参考文献------

%------摘要环境------
\newcommand\enabstractname{ABSTRACT}
\newcommand\enkeywordsname{Key Words}
\newcommand\enkeywords[1]{\vspace{1cm}\noindent{\bfseries\zihao{-4}\enkeywordsname: }#1}
\newenvironment{enabstract}{%
	\newpage
	\centering
	\begin{minipage}{\textwidth}
%	\centerline{\zihao{-3}\bfseries\enabstractname}
	\chapter*{\enabstractname}
	% I would prefer \frontmatter, \mainmatter and \backmatter.
	% Modify if you wish.
	\addcontentsline{toc}{chapter}{\enabstractname}
	\vspace{.3cm}
	\centering
	\begin{minipage}{\textwidth}
	\setlength{\parindent}{1.2em}
}{
\end{minipage}
\end{minipage}
\clearpage
}

\newcommand\cnabstractname{摘\quad要}
\newcommand\cnkeywordsname{关键词}
\newcommand\cnkeywords[1]{\vspace{1cm}\noindent{\bfseries\zihao{-4}\cnkeywordsname: }#1}
\newenvironment{cnabstract}{%
	\newpage
	\centering
	\begin{minipage}{\textwidth}
% Well, the line commented was for ShanDong Univ.
%	\centerline{\zihao{-3}\bfseries\cnabstractname}
	\chapter*{\cnabstractname}
	\addcontentsline{toc}{chapter}{\cnabstractname}
	\vspace{.3cm}
	\centering
	\begin{minipage}[c]{\textwidth}
	\setlength{\parindent}{2em}
	\zihao{-4}
}{
\end{minipage}
\end{minipage}
\clearpage
}
%------摘要环境------

%------中文风格------
\ifchsstyle
%----标题与日期----
\CTEXoptions[figurename={图},tablename={表},bibname={参考文献},contentsname={目\quad{}录}]
\CTEXoptions[today=small]
%----标题与日期----
%----章节样式----
%--chapter
\CTEXsetup[name={第,章}]{chapter}
\CTEXsetup[number={\chinese{chapter}}]{chapter}
\CTEXsetup[format={\centering}]{chapter}
\CTEXsetup[nameformat={\bfseries\zihao{3}}]{chapter}
\CTEXsetup[titleformat={\bfseries\zihao{3}}]{chapter}
\CTEXsetup[aftername={\quad}]{chapter}
\CTEXsetup[beforeskip={10pt}]{chapter}
\CTEXsetup[afterskip={10pt}]{chapter}
%--section
%\CTEXsetup[name={$\S$\,,}]{section}
\CTEXsetup[format={\bfseries\flushleft\zihao{4}}]{section}
%--subsection
\CTEXsetup[format={\bfseries\flushleft\zihao{-4}}]{subsection}
%--subsubsection
\CTEXsetup[format={\flushleft\zihao{-4}}]{subsubsection}
%--appendix
\CTEXsetup[name={附录~}]{appendix}
\CTEXsetup[number={\Alph{chapter}}]{appendix}
%----章节样式----
%----首行缩进----
\RequirePackage{indentfirst}
%----首行缩进----
\else\relax\fi
%------中文风格------

%------封面------
\input{NPUthesis-front-cover.def}
%------封面------

%------声明------
\input{NPUthesis-statement.def}
%------声明------

%------Make------
\newcommand{\maketitlepagestatement}{%
\maketitlepage
\thispagestyle{empty}
~
\vfill\eject
\thispagestyle{empty}
\makestatement
\vfill\eject
\thispagestyle{empty}
~
\vfill\eject
\setcounter{page}{1}
}
\newcommand{\maketableofcontents}{%
\pagenumbering{Roman}
\tableofcontents
\ifdprint
\cleardoublepage
\else
\clearpage
\fi
\pagenumbering{arabic}\setcounter{page}{1}
}
%------Make------
\endinput

%------载入宏包------
%--中文支持
ctex
%--页面设置
geometry
%--页眉页脚
fancyhdr
%--数学支持
amsmath
amsfonts
amsthm
amssymb
amsbsy
bm
mathrsfs
%--图表
graphicx
booktabs
amsmath
%--注释
comment
%------载入宏包------ 