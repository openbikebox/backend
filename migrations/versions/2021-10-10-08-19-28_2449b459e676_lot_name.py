"""lot name

Revision ID: 2449b459e676
Revises: 66de46c37090
Create Date: 2021-10-10 08:19:28.396132

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '2449b459e676'
down_revision = '66de46c37090'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('hardware', sa.Column('lot_name', sa.String(length=192), nullable=True))
    op.create_index(op.f('ix_hardware_lot_name'), 'hardware', ['lot_name'], unique=False)
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_hardware_lot_name'), table_name='hardware')
    op.drop_column('hardware', 'lot_name')
    # ### end Alembic commands ###