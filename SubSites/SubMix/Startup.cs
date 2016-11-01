using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SubMix.Startup))]
namespace SubMix
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
