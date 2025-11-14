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
hc drive.google.com/file/d/1nKQ4S9xt1h6Ii-2vDfgB-ggf667Tdfjn/view

cb prod.idp.collegeboard.org/signin
cbm apclassroom.collegeboard.org/33/assignments?status=assigned
ka khanacademy.org/

krn secure4.saashr.com/ta/6154193.login?rnd=LYJ&NoRedirect=1/
air login.wheniwork.com/
cap verified.capitalone.com/auth/signin/

spl sunnyvale.bibliocommons.com/
    s v2/search?query=

ocs web.cs.ucla.edu/classes/fall25/cs31/

o bruinlearn.ucla.edu/courses/
    c 214058/
    m 215905/
        n files/folder/Notes/
        p files/folder/Dis%204D/Practice%20Problems
        s files/folder/Practice%20(Homework)?preview=21978234
    l 215806/
        m modules/
        a assignments/
    e 215042/
        m modules/
    s 214068/

ob ucla.vitalsource.com/home/my-courses
oz learn.zybooks.com/zybook/UCLACS31SmallbergFall2025

gg messages.google.com/web/u/0/conversations

gp google.com/maps/
    ${googleusers}

gn keep.google.com/
    ${googleusers}

gm mail.google.com/mail/
    ${googleusers}

gd docs.google.com/document/
    ${googleusers}

gs docs.google.com/presentation/
    ${googleusers}

ge docs.google.com/spreadsheets/
    ${googleusers}

gt tasks.google.com/
    ${googleusers}

gc calendar.google.com/
    ${googleusers}

ga myaccount.google.com/
    ${googleusers}

gv drive.google.com/drive/
    ${googleusers}
    s search?q=
    '';
}
