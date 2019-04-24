use Mojo::Base '-strict';

use Test::More;

use RaptoDo::Model::TodoTxt::Item;

my $class = 'RaptoDo::Model::TodoTxt::Item';
is($class->new,     '', 'right result');
is($class->new(''), '', 'right result');

is($class->new('entry'), 'entry', 'right result');

done_testing();
