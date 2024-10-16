{
    conf = let
    googleusers = ''
a u/0/
    s u/1/
    m u/2/
    '';
    in /* bash */ ''
nx mynixos.com/
    s search?q=
hy wiki.hyprland.org/
aur aur.archlinux.org/
    s packages?O=0&K=
auw wiki.archlinux.org/
    s index.php?search=

y youtube.com/
    s results?q=
    l playlist?list=LL

ibkr portal.interactivebrokers.com/
rh robinhood.com/
    s stocks/
    o options/chains/

gh github.com/
gpt chat.openai.com/
ee deepl.com/

spo app.goshippo.com/
bl bricklink.com/v2/main.page

ic fuhsd.infinitecampus.org/campus/portal/students/fremont.jsp
icd fuhsd.infinitecampus.org/campus/nav-wrapper/student/portal/student/documents?appName=fremont
des desmos.com/graphing/

x moz-extension://
    s e282e204-264d-49b8-84c3-609568f6877d/manage.html

a about:
    a addons
    p preferences
    c config

h hhs.fuhsd.org/
    s search-results?q=
    b about-us/general-information/bell-schedule/
hc drive.google.com/file/d/1YfxX1gKARWyNuz-1dtAQt7TUT-89epSY/view
cb prod.idp.collegeboard.org/signin
ka khanacademy.org/

krn secure4.saashr.com/ta/6154193.login?rnd=LYJ&NoRedirect=1/
air login.wheniwork.com/
cap verified.capitalone.com/auth/signin/

spl sunnyvale.bibliocommons.com/
    s v2/search?query=

o fuhsd.schoology.com/
ob bessy.io/
oc fuhsd.schoology.com/course/7380220864/
oh fuhsd.schoology.com/course/7380221161/
om fuhsd.schoology.com/course/7380220637/
oa fuhsd.schoology.com/course/7380221323/
os fuhsd.schoology.com/course/7380220633/
ol fuhsd.schoology.com/course/7380221254/
og fuhsd.schoology.com/grades/grades/
or homework.russianschool.com/

gp google.com/maps
    ${googleusers}

gm mail.google.com/mail/
    ${googleusers}

gd docs.google.com/document/
    ${googleusers}

gs docs.google.com/presentation/
    ${googleusers}

ge docs.google.com/spreadsheets/
    ${googleusers}

ga myaccount.google.com/
    ${googleusers}

gv drive.google.com/drive/
    ${googleusers}
    s search?q=
    '';
}
