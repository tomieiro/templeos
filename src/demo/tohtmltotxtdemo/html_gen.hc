/* This converts $LK,"::/demo/tohtmltotxtdemo/demo_in_page.dd"$ to
an html document named "OutPage.html".

Notice that an entry like $$TX,"GOOGLE",HTML="http://www.google.com"$$
will be converted to text in the html with an html link.

I cheated by hardcoding $LK,"www.templeos.org",A="FF:::/demo/tohtmltotxtdemo/to_html.hc,www.templeos.org"$ as the website
for $LK,"TempleOS Links",A="MN:LK_FILE"$.  Why don't you copy
$LK,"::/demo/tohtmltotxtdemo/to_html.hc"$ to your /Home directory
and modify it?	You are welcome to link to
http://www.templeos.org if you want file that come on the
TempleOS distribution.

You can pass html meta data as args to $LK,"ToHtml",A="FF:::/demo/tohtmltotxtdemo/to_html.hc,ToHtml"$().
*/

Cd(__DIR__);;
#include "ToHtml"

ToHtml("demo_in_page.dd.Z","~/DemoOutPage");
