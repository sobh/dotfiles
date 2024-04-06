#!/usr/bin/env python3

# ---- Modules ----------------------------------------------------------------
import json, tomli_w
import argparse
import sys
import logging

# ---- Utilities --------------------------------------------------------------
# ---- Command Line Arguments ----------
parser = argparse.ArgumentParser(prog='json2toml.py',
                                 description='Convert from "json" file format to "toml" file format.',
                                 )
parser.add_argument('infile', nargs='?', type=argparse.FileType('r'), default=sys.stdin,
                    help='Input file name. If none, will read "stdin".')
parser.add_argument('outfile', nargs='?', type=argparse.FileType('w'), default=sys.stdout,
                    help='Output file name. If none, will output to "stdout".')
parser.add_argument('-v', '--verbose', default=0, action='count', help='Verbosity level.')
args = parser.parse_args()

# ---- Logging -------------------------
v_levels = (logging.WARNING, logging.INFO, logging.DEBUG)
v_level = v_levels[min(args.verbose, len(v_levels) - 1)]

# logging.basicConfig(level=logging.WARNING, format='')
logging.basicConfig(level=logging.WARNING, format='%(levelname)-8s:%(message)s')
logger = logging.getLogger(__name__)
logger.setLevel(v_level)

# ---- Main -------------------------------------------------------------------

json_data = None
try:
    json_data = json.load(args.infile)
except TypeError as e:
    logger.critical(e)
    sys.exit(-1)
args.infile.close()

args.outfile.write(tomli_w.dumps(json_data))
args.outfile.close()
