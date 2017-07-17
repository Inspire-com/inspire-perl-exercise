use Plack::Builder;
use lib 'lib';

my $app = sub {
  my $env = shift;
  return [ 200, ['Content-type'=>'text/html'], ['<h1>Inspire Candidate Exercise</h1>'] ];
};

builder {
    enable "+MiddlewareDB";
    mount "/", $app;
};
