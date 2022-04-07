Untrack .env file
-----------------

::

    git update-index --assume-unchanged .env

    or (re-track)

    git update-index --no-assume-unchanged .env

Flags
-----

:code:`--real` avoids a --dry-run, and :code:`--delete` deletes deleted files
