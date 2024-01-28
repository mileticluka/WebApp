using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface ITagRepository
    {
        public IList<Tag> GetTags();
        public Tag GetTag(int id);
        public IList<Tag> GetTagsForVideo(int videoId);

        public int InsertTag(Tag t);

        public void DeleteTag(int id);

        public void AddTagToVideo(int tagId, int videoId);
        public void RemoveTagFromVideo(int tagId, int videoId);

        public void UpdateTag(int tagId, Tag tag);
    }
}
