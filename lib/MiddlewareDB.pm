package MiddlewareDB;
use parent qw/Plack::Middleware/;
use DBI;

my $dbh;

sub call {
  my ($self, $env) = @_;
  if (!$dbh) {
    $dbh = DBI->connect('dbi:SQLite:dbname=:memory:');
    $dbh->sqlite_backup_from_file('test.db');
  }
  $env->{dbh} = $dbh;
  my $res = $self->app->($env);
  return $res;
}

1;
