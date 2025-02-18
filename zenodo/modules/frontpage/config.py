# -*- coding: utf-8 -*-
#
# This file is part of Zenodo.
# Copyright (C) 2018 CERN.
#
# Zenodo is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# Zenodo is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Zenodo; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307, USA.
#
# In applying this license, CERN does not
# waive the privileges and immunities granted to it by virtue of its status
# as an Intergovernmental Organization or submit itself to any jurisdiction.

"""Configuration for Zenodo Frontpage."""

from __future__ import absolute_import, print_function

ZENODO_FRONTPAGE_BETA_FEATURES = [
    'citations'
]

ZENODO_FRONTPAGE_COMMUNITY = 'zenodo'

ZENODO_FRONTPAGE_FEATURED_COMMUNITIES_COUNT = 3
"""Number of featured communities to be displayed on frontpage."""

ZENODO_FRONTPAGE_FEATURED_RECORDS = []
"""Record PIDs for featured records on frontpage."""

ZENODO_FRONTPAGE_FEATURED_TITLE = None
"""Featured communities and records title (e.g. 'Astrophysics software')."""

ZENODO_FRONTPAGE_FEATURED_COMMUNITY = None
"""Community used for featured records 'Browse more ...' link."""
