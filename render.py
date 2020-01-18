from jinja2 import Environment, FileSystemLoader, Undefined
import yaml


class SilentUndefined(Undefined):
    def _fail_with_undefined_error(self, *args, **kwargs):
        return ''

    __add__ = __radd__ = __mul__ = __rmul__ = __div__ = __rdiv__ = \
        __truediv__ = __rtruediv__ = __floordiv__ = __rfloordiv__ = \
        __mod__ = __rmod__ = __pos__ = __neg__ = __call__ = \
        __getitem__ = __lt__ = __le__ = __gt__ = __ge__ = __int__ = \
        __float__ = __complex__ = __pow__ = __rpow__ = \
        _fail_with_undefined_error


config_data = yaml.safe_load(open('./config/config.yml'))

env = Environment(loader = FileSystemLoader('./config'),
                  trim_blocks = True,
                  lstrip_blocks = True,
                  undefined = SilentUndefined)
template = env.get_template('./Dockerfile-datascience.jinja2')

print(template.render(config_data))

