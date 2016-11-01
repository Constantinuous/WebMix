using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(AspMix.Startup))]
namespace AspMix
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
