"""support long salts

Revision ID: 2bdf858db97c
Revises: fcb9d9a33687
Create Date: 2021-03-03 06:07:28.885342

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '2bdf858db97c'
down_revision = 'fcb9d9a33687'
branch_labels = None
depends_on = None


def upgrade():
    op.execute("ALTER TABLE `resource_access` CHANGE `salt` `salt` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;")


def downgrade():
    op.execute("ALTER TABLE `resource_access` CHANGE `salt` `salt` VARCHAR(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;")
