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

$string = '2019-04-01 entry with creation';
$item = $class->new($string);
is $item,           $string,                'right result';
is $item->creation, '2019-04-01',           'right creation';
is $item->text,     'entry with creation',  'right text';

$string = '(A) 2019-04-01 entry with priority and creation';
$item = $class->new($string);
is $item,           $string,                            'right result';
is $item->priority, 'A',                                'right priority';
is $item->creation, '2019-04-01',                       'right creation';
is $item->text,     'entry with priority and creation', 'right text';

$string = 'x complete entry';
$item = $class->new($string);
is $item,             $string,          'right result';
is $item->completed,  1,                'right completed';
is $item->text,       'complete entry', 'right text';

done_testing();
