#!/usr/bin/python
#-*- mode:Python -*-

import sys, getopt
import simplejson as json
from Cheetah.Template import Template

def usage():
    print "usage : fill-template -e|--env-input <env file> -j|--json-input <JSON file> -t|--template <template file> [-o|--output <output file>]"
    print "   -e|--env-input <env file>         the path to the env file (no support for arrays)"
    print "   -j|--json-input <JSON file>       the path to the JSON file"
    print "   -t|--template <template file>     the path to the cheetah template file"
    print "   -o|--output <output file>         the path to the output file (defaults to stdout)"

def parse_options(argv):
    if len(argv) == 0:
        usage()
        sys.exit(2)
    try:
        opts, args = getopt.getopt(argv, "he:j:y:t:o:", ["help", "env-input=", "json-input=", "template=", "output="])
    except getopt.GetoptError, err:
        print(err)
        usage()
        sys.exit(2)

    env_input = None
    json_input = None
    template = None
    output = None

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt in ("-e", "--env-input"):
            env_input = arg
        elif opt in ("-j", "--json-input"):
            json_input = arg
        elif opt in ("-t", "--template"):
            template = arg
        elif opt in ("-o", "--output"):
            output = arg
    return template, output, env_input, json_input

def readEnv(env_input):
    f = open(env_input, 'r')
    decoded = {}
    for line in f:
        if not(line.startswith("#")) and not(len(line.strip()) == 0):
            tokens = line.split("=", 2)
            decoded[tokens[0]] = tokens[1]
    f.close()
    return decoded

def main(argv):
    template, output, env_input, json_input = parse_options(argv)
    decoded = []
    if env_input == None and json_input == None:
        print "ERROR: Specify at least at one input."
        sys.exit()
    elif env_input != None and json_input != None:
        print "ERROR: Specify only one input."
        sys.exit()
    elif env_input != None:
        decoded.append(readEnv(env_input))
    elif json_input != None:
        for i in json_input.split(","):
            f = open(i, 'r')
            decoded.append(json.loads(f.read()))
            f.close()
    tf = open(template, 'r')
    template_input = tf.read()
    # Merge the template with the data
    t = Template(template_input, searchList=decoded)
    # Print the merged template
    if output == None:
        print t
    else:
        outputFile = open(output, 'w')
        outputFile.write(str(t))
        outputFile.close()

if __name__ == "__main__":
    main(sys.argv[1:])
