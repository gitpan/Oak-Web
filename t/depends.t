#!/usr/bin/perl -w

use strict;
use Test;
BEGIN { plan tests => 2 }

require CGI;
ok(1);
require Oak::Object;
ok(2);
