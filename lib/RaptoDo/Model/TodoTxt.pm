package RaptoDo::Model::TodoTxt;
use Mojo::Base '-base';

use Mojo::File;
use RaptoDo::Model::TodoTxt::Item;

use Mojo::Collection 'c';

has path => 'todo.txt';

sub items {
  my $self = shift;

  my $file = Mojo::File->new($self->path);
  return c() if !-e $file;

  my $handle = $file->open('r');
  return c($handle->getlines)->map(sub { chomp; $_ })->map(sub {
    return RaptoDo::Model::TodoTxt::Item->new($_);
  });
}

1;
