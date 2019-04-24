use Mojo::Base '-strict';

use Test::More;

use RaptoDo::Model::TodoTxt::Item;

my $class = 'RaptoDo::Model::TodoTxt::Item';
is($class->new,     '', 'right result');
is($class->new(''), '', 'right result');

is($class->new('entry'), 'entry', 'right result');

my $string = '(A) entry with priority';
my $item = $class->new($string);
is $item,           $string,                'right result';
is $item->priority, 'A',                    'right priority';
is $item->text,     'entry with priority',  'right text';

done_testing();
