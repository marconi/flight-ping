# -*- coding: utf-8 -*-

import re
import os
import json
import logging
from subprocess import Popen, PIPE
from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response
from pyramid.httpexceptions import HTTPOk


APP_ROOT = os.path.dirname(os.path.abspath(__file__))
logger = logging.getLogger('middleware')

def ping(request):

    logger.debug(request.POST)

    origin = request.POST.get('origin', '')
    destination = request.POST.get('destination', '')
    flight_schedule = request.POST.get('flightschedule', '')
    flight_number = request.POST.get('flightnumber', '')

    status_script = os.path.join(APP_ROOT, 'status.js')
    process = Popen(['phantomjs', status_script, origin, destination,
                     flight_schedule, flight_number],
                    stdout=PIPE)
    output = process.communicate()[0]

    match = re.findall(r'(\{.+\})', output)
    response = match[0] if match else '{}'

    logger.debug("Response: %s" % response)

    return HTTPOk(body=response)

if __name__ == '__main__':
   config = Configurator()
   config.add_route('ping', '/ping')
   config.add_view(ping, route_name='ping', request_method='POST', renderer='json')
   app = config.make_wsgi_app()
   server = make_server('0.0.0.0', 8000, app)
   server.serve_forever()
