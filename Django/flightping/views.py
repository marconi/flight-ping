import re
import os
import logging
from subprocess import Popen, PIPE

from django.utils import simplejson
from django.http import HttpResponse
from django.shortcuts import HttpResponseRedirect
from django.views.decorators.csrf import csrf_exempt


APP_ROOT = os.path.dirname(os.path.abspath(__file__))
logger = logging.getLogger('demo')

@csrf_exempt
def ping(request):
    if request.method == "POST":

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
        if match:
            match = match[0]
        else:
            match = '{}'

        logger.debug("Response: %s" % match)

        return HttpResponse(match, mimetype="application/json")
    return HttpResponseRedirect('/')
