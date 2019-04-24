use Mojo::Base '-strict';

use RaptoDo::Model::TodoTxt;
use Test::More;

use Mojo::File 'tempfile';

my $file = tempfile;
$file->spurt(<<'END');
entry
(A) entry with priority
(A) 2019-04-01 entry with priority and creation
2019-04-01 entry with creation

x complete entry
x 2019-04-02 complete entry with completion
x 2019-04-02 2019-04-01 complete entry with completion & creation
END

my $items = RaptoDo::Model::TodoTxt->new(path => $file)->items;
is $items->size, 8, 'right size';

done_testing();
