#!/usr/bin/env python
import os

f = open(os.path.join(os.environ['STACKATO_APP_ROOT'], 'VCAP_SERVICES.json'), 'w')
f.write(os.environ['VCAP_SERVICES'])
