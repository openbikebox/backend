"""auth methods, calculation

Revision ID: a5488753b697
Revises: 0fdb569171cc
Create Date: 2021-06-08 19:14:24.533381

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'a5488753b697'
down_revision = '0fdb569171cc'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('action', sa.Column('auth_methods', sa.Integer(), nullable=True))
    op.add_column('hardware', sa.Column('supported_auth_methods', sa.Integer(), nullable=True))
    op.add_column('pricegroup', sa.Column('detailed_calculation', sa.Boolean(), nullable=True))
    op.add_column('pricegroup', sa.Column('max_booking_time', sa.Integer(), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('pricegroup', 'max_booking_time')
    op.drop_column('pricegroup', 'detailed_calculation')
    op.drop_column('hardware', 'supported_auth_methods')
    op.drop_column('action', 'auth_methods')
    # ### end Alembic commands ###
