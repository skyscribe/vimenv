let tagfiles = glob("`find ~/.vim/tagfiles -name tags -print`")
let &tags = substitute(tagfiles, "\n", ",", "g")

"Ctags command and taglist
"let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
let Tlist_Show_One_file = 0
let Tlist_Exit_OnlyWindow = 1 "exit if only taglist window exists
let Tlist_Use_Right_Window = 1 "show in right window
let Tlist_Auto_Open=1 "let the taglist open automatically
let Tlist_Enable_Fold_Column=1 "do show folding tree
let Tlist_File_Fold_Auto_Close=1 "fold closed other trees
if filereadable("tags")
    set tags+=tags
endif

" set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]=====>%([%{Tlist_Get_Tagname_By_Line()}]%)


"Set foldmethod as syntax 
set foldmethod=syntax

"CMake support
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime !indent/cmake.vim
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

"OmniCppComplete options and key bindings
let omniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
let OmniCpp_NamespaceSearch = 1 " Avoid coredump by using namespace search?
let OmniCpp_SelectFirstItem = 2 " Select the first one but don't insert

" Close the completion window automatically
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"===============================================================================
"  NESIM Dev environment settings
"===============================================================================
" Tags reload
let s:NESIM_ROOT="/vob/wimax_nesim/"
let s:NESIM_TagFile="~/.vim/tagfiles/nesim/tags"
let s:NESIM_TagDir="~/.vim/tagfiles/nesim/"
let s:NESIM_BldDir=s:NESIM_ROOT."build/".system("uname -p")."/"

function! ReloadNESIMTags()
    if stridx(&tags, s:NESIM_TagFile) == -1
        set tags+=s:NESIM_TagFile
    endif
endfunction

" Tags generation
function! RegenerateNESIMTags()
    call system("cd ".s:NESIM_ROOT)
    echo "Start to generating nesim tag file, be patient..."
    call system(join(["mkdir -p",  s:NESIM_TagDir], " "))
    call system(join(["ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -o", s:NESIM_TagFile, s:NESIM_ROOT], " "))
    echo join(["New nesim tag file", s:NESIM_TagDir,  "tags generated now"], " ")
    call ReloadNESIMTags() 
endfunction

" File tags
let s:ftags="~/.vim/tagfiles/nesimftags"
function! GenerateNESIMFileTags()
    call system("echo !_TAG_FILE_SORTED 2 /2=foldcase/ > ".s:ftags)
    call system("$HOME/bin/mkftags.py /vob/wimax_nesim/ >>".s:ftags)
    echo "ftag file ".s:ftags." generated!"
endfunction

" Generate initial file tags as needed
let g:LookupFile_TagExpr = string(s:ftags)

" Build function scripts
set makeprg=$HOME/bin/mksim.sh\ $*

" Tree explorer
let treeExplVertical=1
let treeExplWinSize=32
let treeExplDirSort=1

"===============================================================================
"  NESIM Dev environment key bindings 
"===============================================================================
"
" Key bindings....
nmap <F11> :call ReloadNESIMTags()<CR>
nmap <F12> :call RegenerateNESIMTags()<CR>

nmap <F6>  :make release<CR>
nmap <F7>  :make debug<CR>
nmap <F8>  :make debugpkg<CR>
nmap <F9>  :make releasepkg<CR>

" Don't ignor alias in bash, problematic?
"set shell=/bin/bash\ -i
"

"===============================================================================
"Pydiction
let g:pydiction_location = '~/.vim/pydiction/complete-dict'

"CtrlP
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
