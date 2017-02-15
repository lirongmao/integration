#!/bin/bash
#
# Copyright 2016-2017 Huawei Technologies Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# delete database data which should be deleted by gso-lcm timing task
# CSIT can not execute timing task  for a long time, so here it deletes database data
docker exec -it gso mysql -uroot -prootpass < ${SCRIPTS}/gso/post_processing.sql

# kill micro service
kill-instance.sh i-msb
kill-instance.sh gso-sgw
kill-instance.sh gso
kill-instance.sh simulator
