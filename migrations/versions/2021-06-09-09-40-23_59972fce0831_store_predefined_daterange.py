"""store predefined daterange

Revision ID: 59972fce0831
Revises: a5488753b697
Create Date: 2021-06-09 09:40:23.028984

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '59972fce0831'
down_revision = 'a5488753b697'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('action', sa.Column('predefined_daterange', sa.Enum('day', 'week', 'month', 'year', name='predefineddaterange'), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('action', 'predefined_daterange')
    # ### end Alembic commands ###
