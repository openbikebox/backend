# encoding: utf-8

"""
openbikebox Backend
Copyright (C) 2021 binary butterfly GmbH

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

from flask_wtf import FlaskForm
from flask_babel import _
from wtforms import validators
from wtforms import StringField, BooleanField, PasswordField, SubmitField, SelectField


class LoginForm(FlaskForm):
    email = StringField(
        _('E-Mail'),
        [
            validators.DataRequired(
                message=_('Bitte geben Sie eine E-Mail-Adresse an')
            )
        ]
    )
    password = PasswordField(
        _('Passwort'),
        [
            validators.DataRequired(
                message=_('Bitte geben Sie ein Passwort ein.')
            )
        ]
    )
    remember_me = BooleanField(
        _('Eingeloggt bleiben'),
        default=False
    )
    submit = SubmitField(_('login'))


class PasswordForm(FlaskForm):
    old_password = PasswordField(
        _('Altes Passwort')
    )
    new_password = PasswordField(
        _('Neues Passwort'),
        [
            validators.Length(
                min=8,
                message=_('Passwort muss aus mindestens 8 Buchstaben bestehen.')
            )
        ]
    )
    confirm = PasswordField(
        _('Neues Passwort (Wiederholung)'),
        [
            validators.DataRequired(
                message=_('Bitte geben Sie ein Passwort ein.')
            ),
            validators.EqualTo(
                'new_password',
                message=_('Passwörter müssen identisch sein.')
            )
        ]
    )
    submit = SubmitField(_('Passwort speichern'))


class UserProfileForm(FlaskForm):
    first_name = StringField(
        label=_('Vorname'),
        validators=[
            validators.DataRequired(
                message=_('Bitte geben Sie einen Vorname an.')
            )
        ]
    )
    last_name = StringField(
        label=_('Nachname'),
        validators=[
            validators.DataRequired(
                message=_('Bitte geben Sie einen Nachnamen an.')
            )
        ]
    )
    company = StringField(
        label=_('Unternehmen')
    )
    address = StringField(
        label=_('Strasse und Hausnummer'),
        validators=[
            validators.DataRequired(
                message=_('Bitte geben Sie Strasse und Hausnummer an.')
            )
        ]
    )
    postalcode = StringField(
        label=_('Postleitzahl'),
        validators=[
            validators.DataRequired(
                message=_('Bitte geben Sie eine Postleitzahl an.')
            )
        ]
    )
    locality = StringField(
        label=_('Ort'),
        validators=[
            validators.DataRequired(
                message=_('Bitte geben Sie einen Ort an.')
            )
        ]
    )
    language = SelectField(
        label=_('Sprache'),
        choices=[('de', _('deutsch')), ('en', _('englisch'))],
        default='de'
    )
    phone = StringField(
        label=_('Telefonnummer'),
        validators=[]
    )
    submit = SubmitField(_('speichern'))


class RecoverForm(FlaskForm):
    email = StringField(
        _('E-Mail Adresse'),
        [
            validators.DataRequired(
                message=_('Bitte geben Sie eine E-Mail-Adresse an')
            ),
            validators.Email(
                message=_('Bitte geben Sie eine korrekte Mailadresse an.')
            )
        ]
    )
    submit = SubmitField(_('Password via E-Mail anfordern'))


class RecoverSetForm(FlaskForm):
    password = PasswordField(
        _('Passwort'),
        [
            validators.DataRequired(
                message=_('Bitte geben Sie ein Passwort ein.')
            ),
            validators.Length(
                min=6,
                max=128,
                message=_('Passwort muss aus mindestens %s Buchstaben bestehen.') % (6)
            )
        ]
    )
    password_repeat = PasswordField(
        _('Passwort (Wiederholung)'),
        [
            validators.DataRequired(
                message=_('Bitte geben Sie ein Passwort ein.')
            ),
            validators.EqualTo('password', message=_('Passwörter müssen identisch sein.'))
        ]
    )
    remember_me = BooleanField(_('Anschließend eingeloggt bleiben'), default=False)
    submit = SubmitField(_('Passwort speichern'))


class UserSettingsForm(FlaskForm):
    email_notification = SelectField(
        label=_('E-Mail Benachrichtigung'),
        validators=[
            validators.DataRequired(
                message=_('Bitte geben Sie eine Form der E-Mail Benachrichtigung an.')
            )
        ],
        choices=[
            ('none', 'keine'),
            ('instant', 'sofort')
        ]
    )
    submit = SubmitField(_('Einstellungen speichern'))
