"""quarter

Revision ID: 66de46c37090
Revises: aaf8cfeb6ba5
Create Date: 2021-09-17 09:55:25.748757

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '66de46c37090'
down_revision = 'aaf8cfeb6ba5'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('pricegroup', sa.Column('fee_quarter', sa.Numeric(precision=7, scale=4), nullable=True))
    # ### end Alembic commands ###
    op.execute("ALTER TABLE `action` CHANGE `predefined_daterange` `predefined_daterange` ENUM('day', 'week', 'month', 'quarter', 'year') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;")


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_index('geometry_index', 'location', ['geometry'], unique=False)
    # ### end Alembic commands ###
    op.execute("ALTER TABLE `action` CHANGE `predefined_daterange` `predefined_daterange` ENUM('day', 'week', 'month', 'year') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;")