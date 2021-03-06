"""souce, user identifier

Revision ID: 877460bb55ba
Revises: f6c014961b4f
Create Date: 2021-05-02 08:18:02.273209

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '877460bb55ba'
down_revision = 'f6c014961b4f'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('action', sa.Column('source', sa.String(length=128), nullable=True))
    op.add_column('action', sa.Column('user_identifier', sa.String(length=255), nullable=True))
    op.create_index(op.f('ix_action_source'), 'action', ['source'], unique=False)
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_action_source'), table_name='action')
    op.drop_column('action', 'user_identifier')
    op.drop_column('action', 'source')
    # ### end Alembic commands ###
