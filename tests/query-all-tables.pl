use strict;
use Hydra::Schema;
use Hydra::Model::DB;

my $db = Hydra::Model::DB->new;

my @sources = $db->schema->sources;
my $nrtables = scalar(@sources);

use Test::Simple tests => 38;

foreach my $source (@sources) {
    my $title = "Basic select query for $source";
    if ($source eq "SchemaVersion" || $source eq "NrBuilds") {
        ok(scalar($db->resultset($source)->all) == 1, $title);
    } elsif( $source !~ m/^LatestSucceeded/) {
        ok(scalar($db->resultset($source)->all) == 0, $title);
    } else {
        ok(scalar($db->resultset($source)->search({},{ bind => ["", "", ""] })) == 0, $title);
    }
}
