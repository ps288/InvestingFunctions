//recall sum of a geometric series: http://www.moneychimp.com/articles/finworks/fmgeom.htm#formula
// f(n) = 1 + z + z^2 + z^3 + . . . + z^n  == [z^n+1 - 1]/[z - 1]
// use this to calc principal remaining on debt as described here: http://www.moneychimp.com/articles/finworks/fmmortgage.htm


//RETURNS: mortgage (debt) principal remaining after:
//y years
//beginning with principal p
//interest rate r 
//paying off monthly amount a

mCalc:{[y;p;r;a]
  m:y*12; r:1+r%12;
  :(p*r xexp m) - a*(-1+r xexp m)%r-1;
 }


//RETURNS: monthly contribution to pay off 
//principal p
//in y years
//at interest rate r
//equivalently: monthly contributions to make principal p in y years with assumed rate of return r
dCalc:{[y;p;r]
  m:y*12;r:r%12;
  :(p*r*(1+r)xexp m)%-1+(1+r)xexp m;
 }
 
//RETURNS: total investment value after:
//y years
//beginning with principal p
//assumed rate of return r
//making monthly contributions a
iCalc:{[y;p;r;a]
  m:y*12;r:1+r%12;
  :(p*r xexp m) + a*(-1+r xexp m)%r-1;
 }


//standard UK stamp duty on property
stampCalc:{[p]
  t:0;
  $[p<=125000;:t;p-:125000];
  $[p<=125000;:t+0.02*p;[t:0.02*125000;p-:125000]];
  $[p<=675000;:t+0.05*p;[t:0.05*675000;p-:675000]];
  $[p<=575000;:t+0.1*p;[t:0.1*575000;p-:575000]];
  :t+0.12*p;
 }


//use this to increae your contributions annually:
oneCalc:iCalc[1;;;]

zCalc:{[i;r;n;a](oneCalc[;i]\)0,a+r*til n}

yCalc:{[i;r;n;a](oneCalc[;i]/)0,n *[1+r;]\a}

//Eg. The following gives the expected return where you increase monthly investment by $5 annually starting with $200 for 18 years at 5% interest
//(oneCalc[;0.05]\)0,200+5*til 18
help:{[]
  -1"Eg. The following gives the expected return where you increase monthly investment by $5 annually starting with $200 for 18 years at 5% interest";
  -1"(oneCalc[;0.05]\\)0,200+5*til 18";
  -1"Eg. The following gives the expected return where you increase monthly investment by 5% annually starting with 105000 earning 5% interest starting monthly contribution: #687.50";
  -1"(oneCalc[;0.05]/)105000,30 *[1.05;]\\687.50";
 }

